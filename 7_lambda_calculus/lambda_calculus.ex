defmodule LambdaCalculus do
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
end
