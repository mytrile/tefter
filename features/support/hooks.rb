require 'timecop'

# Reset time after each step
After do
  Timecop.return
end

