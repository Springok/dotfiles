if ENV['DEV_PASSWORD'].present?
  module Nerv::Pry
    DEV_PASSWORD = ENV['DEV_PASSWORD']
  end
end

fail 'Nerv::Pry::DEV_PASSWORD undefined' unless defined?(Nerv::Pry::DEV_PASSWORD) == 'constant'

Nerv::Pry::DEV_PASSWORD.tap do |pw|
  begin
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    # Patch client id_no
    # Client.update_all("id_no = regexp_replace(id_no, 'x*$', LPAD('x', 5, id))")

    # Producers {{{
    %w[S00 S01].each do |code|
      Producer.find_by_code(code).andand do |pc|
        pc.users.first.update_attribute(:password, pw)
      end
    end
    # }}}

    # Staffs {{{
    Staff.find_by_name('sysadmin').user.update(password: pw)
    # Staff.find_by_name('taki.anaru').andand.user.update(password: pw)
    Staff.find_by_name('veronique.yeh').user.update(password: pw)
    # }}}

    # Clients {{{
    %w(mt000439).each do |login_id|
      User.find_by_login_id(login_id).andand do |user|
        user.skip_confirmation!
        user.update(password: pw)
      end
    end
    # }}}

  ensure
    ActiveRecord::Base.logger = old_logger
  end
end

puts '讚讚讚' if ENV['DEV_PASSWORD'].present?
