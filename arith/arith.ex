defmodule Arith do
  defmodule NoRuleApplies do
    defexception message: "No rule applies"
  end

  def evaluate(term) do
    try do
      evaluate(evaluate1(term))
    rescue
      NoRuleApplies -> term
    end
  end

  def evaluate1({:pred, term}) do
    evaluate1({:pred, term}, is_numeric?(term))
  end

  def evaluate1({:is_zero, term}) do
    evaluate1({:is_zero, term}, is_numeric?(term))
  end

  def evaluate1(term) do
    evaluate1(term, false)
  end

  defp is_numeric?(:zero) do
    true
  end

  defp is_numeric?({:succ, term}) do
    is_numeric?(term)
  end

  defp is_numeric?(_) do
    false
  end

  defp evaluate1({:if, :true, branch, _}, _) do
    branch
  end

  defp evaluate1({:if, :false, _, branch}, _) do
    branch
  end

  defp evaluate1({:if, conditional, branch_1, branch_2}, _) do
    {:if, evaluate1(conditional), branch_1, branch_2}
  end

  defp evaluate1({:succ, term}, _) do
    {:succ, evaluate1(term)}
  end

  defp evaluate1({:pred, :zero}, _) do
    :zero
  end

  defp evaluate1({:pred, {:succ, term}}, true) do
    term
  end

  defp evaluate1({:pred, term}, _) do
    {:pred, evaluate1(term)}
  end

  defp evaluate1({:is_zero, :zero}, _) do
    :true
  end

  defp evaluate1({:is_zero, {:succ, _}}, true) do
    :false
  end

  defp evaluate1({:is_zero, term}, _) do
    {:is_zero, evaluate1(term)}
  end

  defp evaluate1(_, _) do
    raise NoRuleApplies
  end
end
