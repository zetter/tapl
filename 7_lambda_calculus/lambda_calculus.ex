defmodule LambdaCalculus do
  defmodule NoRuleApplies do
    defexception message: "No rule applies"
  end

  def to_string(ctx, term) do
    case term do
      {:abs, x, t1} ->
        {ctx2, x2} = pick_fresh_name(ctx, x)
        "(λ#{x2}. #{to_string(ctx2, t1)})"
      {:app, t1, t2} ->
        "(#{to_string(ctx, t1)} #{to_string(ctx, t2)})"
      {:var, n} ->
        index_to_name(ctx, n)
    end
  end

  defp pick_fresh_name(ctx, x) do
    if Enum.member?(ctx, x) do
      pick_fresh_name(ctx, "#{x}'")
    else
      {[x | ctx], x}
    end
  end

  defp index_to_name(ctx, n) do
    Enum.at(ctx, n)
  end

  def term_shift(d, t) do
    term_shift(d, 0, t)
  end

  defp term_shift(d, c, t) do
    case t do
      {:var, x} when x >= c -> {:var, x + d}
      {:var, x}             -> {:var, x}
      {:abs, x, t1}         -> {:abs, x, term_shift(d, c + 1, t1)}
      {:app, t1, t2}        -> {:app, term_shift(d, c, t1), term_shift(d, c, t2)}
    end
  end

  def term_subst(j, s, t) do
    term_subst(j, s, 0, t)
  end

  defp term_subst(j, s, c, t) do
    case t do
      {:var, x} when x == j + c -> term_shift(c, s)
      {:var, x}                 -> {:var, x}
      {:abs, x, t1}             -> {:abs, x, term_subst(j, s, c + 1, t1)}
      {:app, t1, t2}            -> {:app, term_subst(j, s, c, t1), term_subst(j, s, c, t2)}
    end
  end

  def term_subst_top(s, t) do
    term_shift(-1, term_subst(0, term_shift(1, s), t))
  end

  defp is_val(_, t) do
    case t do
      {:abs, _, _} -> true
      _            -> false
    end
  end

  def eval1(ctx, t) do
    t1_is_val = is_val(ctx, Enum.at(Tuple.to_list(t), 1))
    t2_is_val = is_val(ctx, Enum.at(Tuple.to_list(t), 2))

    case {t, t1_is_val, t2_is_val} do
      {{:app, {:abs, _, t1_2}, v2}, _, true} -> term_subst_top(v2, t1_2)
      {{:app, v1, t2}, true, _}             -> {:app, v1, eval1(ctx, t2)}
      {{:app, t1, t2}, _, _}                -> {:app, eval1(ctx, t1), t2}
      _                                     -> raise NoRuleApplies
    end
  end

  def eval(ctx, t) do
    try do
      eval(ctx, eval1(ctx, t))
    rescue
      NoRuleApplies -> t
    end
  end
end
