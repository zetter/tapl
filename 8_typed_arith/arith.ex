defmodule Arith do
  defmodule NotWellTyped do
    defexception message: "Not well typed"
  end

  defmodule NotWellFormed do
    defexception message: "Not well formed"
  end

  def type(term) when term in [:true, :false], do: :bool

  def type({:if, t1, t2, t3}) do
    type_t1 = type(t1)
    type_t2 = type(t2)
    type_t3 = type(t3)

    if (type_t1 == :bool) && (type_t2 == type_t3) do
      type_t2
    else
      raise NotWellTyped
    end
  end

  def type(:zero), do: :nat

  def type({nat_op, t1}) when nat_op in [:succ, :pred] do
    if type(t1) == :nat do
      :nat
    else
      raise NotWellTyped
    end
  end

  def type({:is_zero, t1}) do
    if type(t1) == :nat do
      :bool
    else
      raise NotWellTyped
    end
  end

  def type(_), do: raise NotWellFormed
end
