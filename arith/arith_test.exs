ExUnit.start

defmodule ArithTest do
  use ExUnit.Case, async: true
  ExUnit.start(timeout: 100)

  test 'values' do
    assert Arith.eval(:true) == :true
    assert Arith.eval(:false) == :false
    assert Arith.eval(:zero) == :zero
  end

  test 'conditionals' do
    assert Arith.eval({:if, :true, :true, :false}) == :true
    assert Arith.eval({:if, :false, :true, :false}) == :false
    assert Arith.eval({:if, {:if, :true, :true, :false}, :true, :false}) == :true
    assert Arith.eval({:if, {:if, :false, :true, :false}, :true, :false}) == :false
    assert Arith.eval({:if, :true, {:if, :true, :true, :true}, :false}) == :true
    assert Arith.eval({:if, :false, :true, {:if, :true, :false, :false}}) == :false
  end

  test 'pred and succ' do
    assert Arith.eval({:succ, :zero}) == {:succ, :zero}
    assert Arith.eval({:pred, :zero}) == :zero
    assert Arith.eval({:succ, {:pred, :zero}}) == {:succ, :zero}
    assert Arith.eval({:pred, {:succ, :zero}}) == :zero
    assert Arith.eval({:pred, {:succ, :true}}) == {:pred, {:succ, :true}}
  end

  test 'is zero' do
    assert Arith.eval({:is_zero, :zero}) == :true
    assert Arith.eval({:is_zero, {:pred, :zero}}) == :true
    assert Arith.eval({:is_zero, {:succ, :zero}}) == :false
    assert Arith.eval({:is_zero, {:succ, :true}}) == {:is_zero, {:succ, :true}}
  end
end
