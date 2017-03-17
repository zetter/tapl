ExUnit.start

defmodule LambdaCalculusTest do
  use ExUnit.Case, async: true
  ExUnit.start(timeout: 100)

  test 'to_string' do
    assert LambdaCalculus.to_string([], {:abs, "x", {:var, 0}}) == "(λx. x)"
    assert LambdaCalculus.to_string([], {:abs, "t", {:abs, "f", {:var, 1}}}) == "(λt. (λf. t))"
    assert LambdaCalculus.to_string([], {:abs, "t", {:abs, "f", {:var, 0}}}) == "(λt. (λf. f))"
  end
end
