defmodule Helpers do
  def abs(x, type, t) do
    {:abs, x, type, t}
  end

  def var(n) do
   {:var, n}
  end

  def app(t1, t2) do
    {:app, t1, t2}
  end

  def tm_if(t1, t2, t3) do
    {:if, t1, t2, t3}
  end

  def type_arr(type_1, type_2) do
    {:type_arr, type_1, type_2}
  end

  def type_bool do
    :type_bool
  end

  def tm_true do
    :true
  end

  def tm_false do
    :true
  end
end
