ExUnit.start

defmodule ArithTest do
  use ExUnit.Case, async: true

  test 'true and false' do
    assert Arith.evaluate(:true) == :true
    assert Arith.evaluate(:false) == :false
  end

  test 'conditionals' do
    assert Arith.evaluate({:if, :true, :true, :false}) == :true
    assert Arith.evaluate({:if, :false, :true, :false}) == :false
    assert Arith.evaluate({:if, {:if, :true, :true, :false}, :true, :false}) == :true
    assert Arith.evaluate({:if, {:if, :false, :true, :false}, :true, :false}) == :false
    assert Arith.evaluate({:if, :true, {:if, :true, :true, :true}, :false}) == :true
    assert Arith.evaluate({:if, :false, :true, {:if, :true, :false, :false}}) == :false
  end
end
