require 'timecop'
require 'chronic'

# Reset time after each step
After do
  Timecop.return
end

