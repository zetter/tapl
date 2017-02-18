ExUnit.start

defmodule ArithTest do
  use ExUnit.Case, async: true

  test 'values' do
    assert Arith.evaluate(:true) == :true
    assert Arith.evaluate(:false) == :false
    assert Arith.evaluate(:zero) == :zero
  end

  test 'conditionals' do
    assert Arith.evaluate({:if, :true, :true, :false}) == :true
    assert Arith.evaluate({:if, :false, :true, :false}) == :false
    assert Arith.evaluate({:if, {:if, :true, :true, :false}, :true, :false}) == :true
    assert Arith.evaluate({:if, {:if, :false, :true, :false}, :true, :false}) == :false
    assert Arith.evaluate({:if, :true, {:if, :true, :true, :true}, :false}) == :true
    assert Arith.evaluate({:if, :false, :true, {:if, :true, :false, :false}}) == :false
  end

  test 'pred and succ' do
    assert Arith.evaluate({:succ, :zero}) == {:succ, :zero}
    assert Arith.evaluate({:pred, :zero}) == :zero
    assert Arith.evaluate({:succ, {:pred, :zero}}) == {:succ, :zero}
    assert Arith.evaluate({:pred, {:succ, :zero}}) == :zero
  end
end
