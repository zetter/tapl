defmodule Arith do
  def evaluate({:if, :true, branch, _}) do
    evaluate(branch)
  end

  def evaluate({:if, :false, _, branch}) do
    evaluate(branch)
  end

  def evaluate({:if, conditional, branch_1, branch_2}) do
    evaluate({:if, evaluate(conditional), branch_1, branch_2})
  end

  def evaluate(:true) do
    :true
  end

  def evaluate(:false) do
    :false
  end
end
