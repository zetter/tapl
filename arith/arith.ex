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

  def evaluate({:succ, term}) do
    {:succ, evaluate(term)}
  end

  def evaluate({:pred, :zero}) do
    :zero
  end

  def evaluate({:pred, {:succ, term}}) do
    term
  end

  def evaluate({:pred, term}) do
    {:pred, evaluate(term)}
  end

  def evaluate(:true) do
    :true
  end

  def evaluate(:false) do
    :false
  end

  def evaluate(:zero) do
    :zero
  end
end
