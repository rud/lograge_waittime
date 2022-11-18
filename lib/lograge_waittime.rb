require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

module LogrageWaittime
end

loader.eager_load
