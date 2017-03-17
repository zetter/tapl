ExUnit.start

defmodule LambdaCalculusTest do
  def abs(x, t) do
    {:abs, x, t}
  end

  def var(n) do
   {:var, n}
  end

  def app(t1, t2) do
    {:app, t1, t2}
  end

  use ExUnit.Case, async: true
  ExUnit.start(timeout: 100)

  test 'to_string' do
    assert LambdaCalculus.to_string([], abs("x", var(0))) == "(λx. x)"
    assert LambdaCalculus.to_string([], abs("t", abs("f", var(1)))) == "(λt. (λf. t))"
    assert LambdaCalculus.to_string([], abs("t", abs("f", var(0)))) == "(λt. (λf. f))"
  end
end
