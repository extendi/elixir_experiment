defmodule DetectStudents do
  def students do
    [
      %{name: "matte", esami: [30, 17, 20], age: 40},
      %{name: "carmine", esami: [10, 7, 8], age: 23},
      %{name: "meox", esami: [1, 2, 3], age: 37},
      %{name: "elia", esami: [10, 20, 20], age: 30}
    ]
  end

  def best() do
    DetectStudents.students()
    |> Enum.reduce(
      %{max: 0, name_max: nil, min: nil, name_min: nil}, fn %{name: student, esami: voti}, %{max: max, name_max: name_max, min: min, name_min: name_min} ->

        voto_max = Enum.max(voti)
        voto_min = Enum.min(voti)

        %{
          max: Enum.max([max, voto_max]),
          name_max: (if voto_max > max, do: student, else: name_max),
          min: Enum.min([min, voto_min]),
          name_min: (if voto_min < min, do: student, else: name_min)
        }
    end)
  end
end
