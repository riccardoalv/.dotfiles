show_docker_status() {
  local index icon color text module

  index=$1

  icon="$(  get_tmux_option "@catppuccin_docker_status_icon"  " 󰡨 "           )"
  color="$( get_tmux_option "@catppuccin_docker_status_color" "$thm_blue" )"
  text="$(  get_tmux_option "@catppuccin_docker_status_text"  "#(docker ps -q | wc -l)" )"

  module=$( build_status_module "$index" "$icon" "$color" "$text" )

  echo "$module"
}
