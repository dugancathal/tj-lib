class TerminalShell
  def exec(command)
    `#{command}`
  end
end

class TextShell
  def exec(command)
    puts command
  end
end
