module Tmux
  class Pane
    def initialize(window_name, title, pane_id, active, shell)
      @title = title
      @pane_id = pane_id
      @window_name = window_name
      @active = active
      @shell = shell
    end

    def send_keys(command)
      shell.exec("tmux send-keys -t #{name} C-c '#{command}' C-m")
    end

    def notify_signal_command(name)
      "tmux wait-for -S #{name}"
    end

    def select
      shell.exec("tmux select-pane -t #{name}")
    end

    def split(dir)
      fail "dir must be one of :vertical or :horizontal" unless %i(vertical horizontal).include?(dir)
      dir_flag = dir == :vertical ? '-h' : '-v'
      shell.exec("tmux split-pane -t #{name} #{dir_flag}")

      current_pane_id = Tmux.current_pane_id(shell, window_name)
      self.class.new(window_name, "", current_pane_id, true, shell)
    end

    def active?
      @active
    end

    def name
      "#{window_name}.#{pane_id}"
    end

    def title
      @title
    end

    def name=(new_title)
      shell.exec("tmux select-pane -t #{name} -T #{new_title}")
      @title = new_title
      name
    end

    def within(&block)
      instance_eval(&block)
    end

    private
    attr_reader :window_name, :pane_name, :pane_id, :shell
  end
end
