require 'awesome_print'

AwesomePrint.pry!

Pry.config.commands.alias_command('at', 'whereami')
Pry.config.commands.alias_command 'ep', 'exit-program'

if defined? Nerv
  # BP  = BasicPlan
  # CC  = ContributionCollection
  # CB  = ContributionBatch
  # CR  = ContributionRecord
  # PD  = PlanDealing
  # PDI = PlanDealingItem
  # FD  = FundDealing
  # FDI = FundDealingItem

  # got this trick from godwin
  # def _bp(id_or_no)
  #   case id_or_no
  #   when Integer then BP.find(id_or_no)
  #   when Symbol  then _bp(id_or_no.to_s)
  #   when String
  #     id_or_no = id_or_no[0] + '0100' + id_or_no[1..4] if id_or_no =~ /[r|s]\d{4}/i
  #     BP.find_by(plan_no: id_or_no.upcase)
  #   end
  # end

  module Nerv::Pry
    RESOURCE_TYPES = {
      bp:  'BasicPlan',
      tu:  'TopUp',
      sr:  'ServiceRecord',
      cb:  'ContributionBatch',
      cc:  'ContributionCollection',
      cr:  'ContributionRecord',
      pd:  'PlanDealing',
      pdi: 'PlanDealingItem',
      fd:  'FundDealing',
      fdi: 'FundDealingItem',
    }

    DEV_PASSWORD = 'foobar'
  end

  Pry::Commands.create_command 'nerv-resource' do
    group 'Nerv'
    description 'Get nerv resource and assign to variable'

    banner <<-BANNER
      Usage: nerv-resource TYPE QUERY
             nerv-resource TYPE QUERY [ --to VAR ]

      Get nerv resource by id or keyword, and assign it to a variable.
      Supported types:
        #{Nerv::Pry::RESOURCE_TYPES.keys.join(' ')}

      Examples:

      nerv-resource sr 666               get SR #666 and assign to `sr`
      nerv-resource bp r1677 --to bp2    get BP R01001677 and assign to `bp2`
      nerv-resource fd2 42               get FD #42 and assign to `fd2`

      Append `;` to suppress the eval output.
    BANNER

    command_options :listing => "nerv-resource"

    def options(opt)
      opt.on '-t', '--to=', 'variable name to assign to'
    end

    def process
      type = args[0].to_s
      var  = opts.to? ? opts[:to] : type
      q    = args.from(1).join(' ').strip
      mod  = ''

      # 1st argument can be parsed as 'type + var'
      type = Nerv::Pry::RESOURCE_TYPES.keys.sort_by(&:length).reverse.detect do |short_name|
        type.start_with? short_name.to_s
      end

      if opts.to? && (args[0] != type.to_s) && (opts[:to] != args[0])
        msg = "WARNING: var name from arg (#{args[0]}) overwritten by option (#{opts[:to]})"
        output.puts Pry.config.color ? Pry::Helpers::Text.bright_red(msg) : msg
      end

      raise Pry::CommandError, "Unknown resource type '#{type}'"          if type.nil?
      raise Pry::CommandError, "Invalid variable name '#{var}'"           if var !~ /\A[a-z0-9_]+\z/
      raise Pry::CommandError, "Query can't be blank"                     if q.blank?

      klass = Nerv::Pry::RESOURCE_TYPES.fetch(type)

      [q, var].each do |s|
        if %[;].include?(s[-1])
          s.chop!
          mod = ';'
        end
      end

      if type == :bp && q =~ /\A[a-z]/i
        plan_no = q.upcase.sub(/([A-Z]+)(\d*)/) do |_|
          $1 << '_0100100'.from($1.size).first(9 - q.size).to_s << $2.to_s
        end
        cmd = "#{var} = BasicPlan.find_by(plan_no: '#{plan_no}')"
      elsif type == :tu && q =~ /\A[a-z]/i
        plan_no = q.upcase.sub(/([A-Z]+)(\d*)(-001)?/) do |_|
          $1 << '_0100100'.from($1.size).first(9 - $1.size - $2.to_s.size).to_s << $2.to_s << '-001'
        end
        cmd = "#{var} = TopUp.find_by(plan_no: '#{plan_no}')"
      else
        cmd = "#{var} = #{klass}.find(#{q})"
      end

      eval_string << cmd << mod.to_s
    end
  end

  Pry.commands.alias_command('=', 'nerv-resource')
  Pry.commands.alias_command(/=((?:#{Nerv::Pry::RESOURCE_TYPES.keys.join('|')})\w*)/, "nerv-resource")
end
