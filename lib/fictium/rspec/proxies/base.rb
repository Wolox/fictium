module Fictium
  module RSpec
    module Proxies
      class Base
        attr_reader :context, :args, :first_arg, :kwargs
        def initialize(context, *args, **kwargs)
          @context = context
          @first_arg = args.shift
          @args = args
          @kwargs = kwargs
        end

        def evaluate(block, extra_args, extra_kwargs)
          list_arguments = first_arg + args + extra_args
          key_arguments = extra_kwargs.merge(kwargs).merge(additional_arguments)
          context.send(evaluate_method_name, *list_arguments, **key_arguments, &block)
        end

        def evaluate_method_name
          :describe
        end
      end
    end
  end
end
