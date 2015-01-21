describe "Routine" do
  before do
    routine_data = DATA["routines"][0]
    @routine = Routine.new(routine_data)
  end

  describe "initialize" do
    it "sets the id" do
      @routine.id.should == 1
    end

    it "sets the name" do
      @routine.name.should == "Treino A - Peito e Tríceps"
    end

    it "sets the rest" do
      @routine.rest.should == 60
    end

    it "sets the exercises" do
      @routine.exercises.length.should == 9
    end
  end

  describe "next" do
    it "goes to the next exercise" do
      @routine.next.should == @routine.exercises[0]
      @routine.next.should == @routine.exercises[1]
    end

    it "returns null when there are no more exercises" do
      @routine.reset
      9.times { @routine.next }
      @routine.next.should == nil
    end
  end
end

DATA = {"routines"=>[{"id"=>1, "name"=>"Treino A - Peito e Tríceps", "rest"=>60, "exercises"=>[{"id"=>1, "name"=>"Supino Reto", "sets"=>4, "reps"=>10, "load"=>40, "rest"=>30}, {"id"=>2, "name"=>"Cross Over 25", "sets"=>2, "reps"=>"10+12+14+16", "load"=>[[18, 16, 14, 12], [18, 16, 14, 12]], "rest"=>45}, {"id"=>3, "name"=>"Supino Inclinado 34", "sets"=>3, "reps"=>"10+20", "load"=>[[30, 20], [30, 20], [30, 20]], "rest"=>60}, {"id"=>4, "name"=>"Crucifixo Pronado Inclinado", "sets"=>3, "reps"=>10, "load"=>18, "rest"=>50}, {"id"=>5, "name"=>"Tríceps Francês 25", "sets"=>4, "reps"=>10, "load"=>8, "rest"=>30}, {"id"=>6, "name"=>"Tríceps Testa Barra W + Halter Unilat", "sets"=>3, "reps"=>"10+8", "rest"=>60}, {"id"=>7, "name"=>"Tríceps Banco", "sets"=>3, "reps"=>15, "rest"=>45}, {"id"=>8, "name"=>"Abd Supra Corda (Joelho) 25", "sets"=>3, "reps"=>20, "rest"=>60}, {"id"=>8, "name"=>"Abd Supra C/ S/ Carga 34", "sets"=>3, "reps"=>"10+20", "rest"=>60}]}, {"id"=>2, "name"=>"Treino B - Costas e Bíceps", "rest"=>60, "exercises"=>[{"id"=>8, "name"=>"Remada Curvada Aberta Smith", "sets"=>4, "reps"=>"8+10", "rest"=>60}, {"id"=>9, "name"=>"Barra Fixa Supinada 28", "sets"=>4, "reps"=>"...", "rest"=>45}, {"id"=>10, "name"=>"Pull Down 25", "sets"=>3, "reps"=>15, "rest"=>45}, {"id"=>10, "name"=>"Pull Down 25", "sets"=>3, "reps"=>15, "rest"=>45}, {"id"=>10, "name"=>"Remada Cavalinho /\\", "sets"=>2, "rest"=>45, "reps"=>"10+12+14+16"}, {"id"=>10, "name"=>"Rosca Direta Deitado 25", "sets"=>3, "rest"=>60, "reps"=>"8+10+12"}, {"id"=>10, "name"=>"Rosca Conc.Scott Halter Unilateral", "sets"=>3, "rest"=>60, "reps"=>"8+20"}, {"id"=>10, "name"=>"Rosca Alternada c/ Isometria", "sets"=>3, "rest"=>30, "reps"=>"10"}, {"id"=>10, "name"=>"Abd Oblíquo Corda 25", "sets"=>3, "rest"=>60, "reps"=>"20"}, {"id"=>10, "name"=>"Abd Oblíquo 25", "sets"=>3, "rest"=>30, "reps"=>"20"}]}, {"id"=>3, "name"=>"Treino C - Pernas e Ombros", "rest"=>60, "exercises"=>[{"id"=>40, "name"=>"Levantamento Terra Barra Supino", "sets"=>4, "reps"=>10, "load"=>30, "rest"=>30}]}]}
