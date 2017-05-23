ExUnit.start

defmodule LambdaCalculusTest do
  import Helpers

  use ExUnit.Case, async: true
  ExUnit.start(timeout: 100)

  test 'types when using abs and app' do
    bool_to_bool = abs("n", type_bool(), var(0))
    assert LambdaCalculus.type_of(bool_to_bool) == type_arr(type_bool(), type_bool())
    assert LambdaCalculus.type_of(app(abs("n", type_bool(), var(0)), tm_true())) == type_bool()

    assert_raise RuntimeError, "parameter type mismatch", fn ->
      LambdaCalculus.type_of(app(abs("n", type_bool(), var(0)), bool_to_bool))
    end
  end

  test 'types when using true and false' do
    assert LambdaCalculus.type_of(tm_true()) == type_bool()
    assert LambdaCalculus.type_of(tm_true()) == type_bool()
    assert LambdaCalculus.type_of(tm_if(tm_true(), tm_true(), tm_false())) == type_bool()

    bool_to_bool = abs("n", type_bool(), var(0))
    assert LambdaCalculus.type_of(tm_if(tm_true(), bool_to_bool, bool_to_bool)) == type_arr(type_bool(), type_bool())

    assert_raise RuntimeError, "arms of conditional have different types", fn ->
      LambdaCalculus.type_of(tm_if(tm_false(), tm_true(), bool_to_bool))
    end

    assert_raise RuntimeError, "guard of conditional not a boolean", fn ->
      LambdaCalculus.type_of(tm_if(bool_to_bool, tm_false(), tm_false()))
    end
  end

end
