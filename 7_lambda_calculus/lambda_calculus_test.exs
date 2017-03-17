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

  test 'termShift' do
    assert LambdaCalculus.term_shift(2, abs("x", abs("y", app(var(1), app(var(0), var(2)))))) ==  abs("x", abs("y", app(var(1), app(var(0), var(4)))))
    assert LambdaCalculus.term_shift(2, abs("x", app(app(var(0), var(1)), abs("y", app(app(var(0), var(1)), var(2)))))) == abs("x", app(app(var(0), var(3)), abs("y", app(app(var(0), var(1)), var(4)))))
  end

  test 'termSubst' do
    assert LambdaCalculus.term_subst(0, var(1), app(var(0), abs("x", abs("y", var(2))))) == app(var(1), abs("x", abs("y", var(3))))
    assert LambdaCalculus.term_subst(0, app(var(1), abs("a", var(2))), app(var(0), abs("x", var(1)))) == app(app(var(1), abs("a", var(2))), abs("x", app(var(2), abs("a", var(3)))))
    assert LambdaCalculus.term_subst(0, var(1), abs("b", app(var(0), var(2)))) == abs("b", app(var(0), var(2)))
    assert LambdaCalculus.term_subst(0, var(1), abs("x", app(var(1), var(0)))) == abs("x", app(var(2), var(0)))
  end
end
