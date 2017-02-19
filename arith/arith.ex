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

  defp isnumericalval(term) do
    case term do
      :zero         -> true
      {:succ, term} -> isnumericalval(term)
      _             -> false
    end
  end

  def eval1(term) do
    nested_numeric_val = case term do
      {:is_zero, term} -> isnumericalval(term)
      {:pred, term}    -> isnumericalval(term)
      _                -> false
    end

    case {term, nested_numeric_val} do
      {{:if, :true, t2, _ }, _} -> t2
      {{:if, :false, _, t3}, _} -> t3
      {{:if, t1, t2, t3}, _}    -> {:if, eval1(t1), t2, t3}

      {{:succ, t1}, _}             -> {:succ, eval1(t1)}

      {{:pred, :zero}, _}          -> :zero
      {{:pred, {:succ, t1}}, true} -> t1
      {{:pred, t1}, _}             -> {:pred, eval1(t1)}

      {{:is_zero, :zero}, _}         -> :true
      {{:is_zero, {:succ, _}}, true} -> :false
      {{:is_zero, t1}, _}            -> {:is_zero, eval1(t1)}

      {_, _} -> raise NoRuleApplies
    end
  end
end
