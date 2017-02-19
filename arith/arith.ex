defmodule Arith do
  defmodule NoRuleApplies do
    defexception message: "No rule applies"
  end

  def eval(term) do
    try do
      eval(eval1(term))
    rescue
      NoRuleApplies -> term
    end
  end

  def eval1({:pred, term}) do
    eval1({:pred, term}, is_numeric?(term))
  end

  def eval1({:is_zero, term}) do
    eval1({:is_zero, term}, is_numeric?(term))
  end

  def eval1(term) do
    eval1(term, false)
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

  defp eval1({:if, :true, branch, _}, _) do
    branch
  end

  defp eval1({:if, :false, _, branch}, _) do
    branch
  end

  defp eval1({:if, conditional, branch_1, branch_2}, _) do
    {:if, eval1(conditional), branch_1, branch_2}
  end

  defp eval1({:succ, term}, _) do
    {:succ, eval1(term)}
  end

  defp eval1({:pred, :zero}, _) do
    :zero
  end

  defp eval1({:pred, {:succ, term}}, true) do
    term
  end

  defp eval1({:pred, term}, _) do
    {:pred, eval1(term)}
  end

  defp eval1({:is_zero, :zero}, _) do
    :true
  end

  defp eval1({:is_zero, {:succ, _}}, true) do
    :false
  end

  defp eval1({:is_zero, term}, _) do
    {:is_zero, eval1(term)}
  end

  defp eval1(_, _) do
    raise NoRuleApplies
  end
end
