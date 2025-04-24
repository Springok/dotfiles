# Put your costomized zshrc config here
# alias gss='git status'

# reference: https://abagile.slack.com/archives/C0RDD9J8L/p1744362188330009
dc() {
  local action="${1:-}"
  local site="${2:-hk}" # 預設 hk，如果想測 hk 後面都不用打 site code，打 action 就好
  local compose_file=""

  case "$site" in
    hq)
      compose_file="/current/$site/compose.yml"
      ;;
    hk|ck|sg|ave_ck)
      compose_file="/current/sites/nerv_by_site_code/$site/compose.yml"
      ;;
    *)
      echo "unknown code: $site !"
      return 1
      ;;
  esac

  case "$action" in
    up)
      docker compose -f "$compose_file" up -d
      ;;
    down)
      docker compose -f "$compose_file" down
      ;;
    ps)
      docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}" | grep -i "^$site-"
      ;;
    attach)
      local container_name
      container_name=$(docker ps --format "{{.Names}}" | grep -i "nerv_${site}" | head -n1)
      if [[ -n "$container_name" ]]; then
        echo "match container: $container_name"
        docker attach --sig-proxy=false --detach-keys=ctrl-d "$container_name"
      else
        echo "no match nerv_${site} container"
        return 1
      fi
      ;;
    *)
      echo "unknown action: $action !"
      return 1
      ;;
  esac
}
