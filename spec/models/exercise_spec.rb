describe "Exercise" do
  before do
    routine_data = DATA["routines"][0]
    routine = Routine.new(routine_data)
    @exercise = routine.exercises[0]
    @exercise.reps = 2
  end

  describe "next_set" do
    before do
      @exercise.reset
      @exercise.start
    end

    it "increments the current_set" do
      @exercise.current_set.should == 1
      @exercise.next_set
      @exercise.current_set.should == 2
    end

    # it "changes status to finished after all reps" do
    #   @exercise.next_set
    #   @exercise.next_set
    #   @exercise.status.should == 'started'
    # end
  end

  describe "rest" do
    before do
      @exercise.start
    end

    it "changes the status to resting" do
      @exercise.next_set
      @exercise.rest
      @exercise.status.should == 'resting'
    end

    it "fails if the exercise has not been started" do
      begin
        @exercise.finish
        @exercise.rest
        raise 'Exception should have been raised'
      rescue
        $!.message.should == 'Not started'
      end
    end
  end

  describe "start" do
    before do
      @exercise.reset
      @exercise.start
    end

    it "changes the current rep to 1" do
      @exercise.current_set.should == 1
    end

    it "changes the status to started" do
      @exercise.status.should == 'started'
    end

    it "is started" do
      @exercise.started?.should == true
    end
  end

  describe "started?" do
    before do
      @exercise.reset
    end

    it "is false when not started" do
      @exercise.started?.should == false
    end

    it "is true when started" do
      @exercise.start
      @exercise.started?.should == true
    end
  end

  describe "finish" do
    before do
      @exercise.finish
    end

    it "changes the status to finished" do
      @exercise.status.should == 'finished'
    end
  end

  describe "status" do
    it "is not_started by default" do
      @exercise.status.should == 'not_started'
    end

    it "is started when we start" do
      @exercise.start
      @exercise.status.should == 'started'
    end
  end
end

DATA = {"routines"=>[{"id"=>1, "name"=>"Treino A - Peito e Tríceps", "rest"=>60, "exercises"=>[{"id"=>1, "name"=>"Supino Reto", "sets"=>4, "reps"=>10, "load"=>40, "rest"=>30}, {"id"=>2, "name"=>"Cross Over 25", "sets"=>2, "reps"=>"10+12+14+16", "load"=>[[18, 16, 14, 12], [18, 16, 14, 12]], "rest"=>45}, {"id"=>3, "name"=>"Supino Inclinado 34", "sets"=>3, "reps"=>"10+20", "load"=>[[30, 20], [30, 20], [30, 20]], "rest"=>60}, {"id"=>4, "name"=>"Crucifixo Pronado Inclinado", "sets"=>3, "reps"=>10, "load"=>18, "rest"=>50}, {"id"=>5, "name"=>"Tríceps Francês 25", "sets"=>4, "reps"=>10, "load"=>8, "rest"=>30}, {"id"=>6, "name"=>"Tríceps Testa Barra W + Halter Unilat", "sets"=>3, "reps"=>"10+8", "rest"=>60}, {"id"=>7, "name"=>"Tríceps Banco", "sets"=>3, "reps"=>15, "rest"=>45}, {"id"=>8, "name"=>"Abd Supra Corda (Joelho) 25", "sets"=>3, "reps"=>20, "rest"=>60}, {"id"=>8, "name"=>"Abd Supra C/ S/ Carga 34", "sets"=>3, "reps"=>"10+20", "rest"=>60}]}, {"id"=>2, "name"=>"Treino B - Costas e Bíceps", "rest"=>60, "exercises"=>[{"id"=>8, "name"=>"Remada Curvada Aberta Smith", "sets"=>4, "reps"=>"8+10", "rest"=>60}, {"id"=>9, "name"=>"Barra Fixa Supinada 28", "sets"=>4, "reps"=>"...", "rest"=>45}, {"id"=>10, "name"=>"Pull Down 25", "sets"=>3, "reps"=>15, "rest"=>45}, {"id"=>10, "name"=>"Pull Down 25", "sets"=>3, "reps"=>15, "rest"=>45}, {"id"=>10, "name"=>"Remada Cavalinho /\\", "sets"=>2, "rest"=>45, "reps"=>"10+12+14+16"}, {"id"=>10, "name"=>"Rosca Direta Deitado 25", "sets"=>3, "rest"=>60, "reps"=>"8+10+12"}, {"id"=>10, "name"=>"Rosca Conc.Scott Halter Unilateral", "sets"=>3, "rest"=>60, "reps"=>"8+20"}, {"id"=>10, "name"=>"Rosca Alternada c/ Isometria", "sets"=>3, "rest"=>30, "reps"=>"10"}, {"id"=>10, "name"=>"Abd Oblíquo Corda 25", "sets"=>3, "rest"=>60, "reps"=>"20"}, {"id"=>10, "name"=>"Abd Oblíquo 25", "sets"=>3, "rest"=>30, "reps"=>"20"}]}, {"id"=>3, "name"=>"Treino C - Pernas e Ombros", "rest"=>60, "exercises"=>[{"id"=>40, "name"=>"Levantamento Terra Barra Supino", "sets"=>4, "reps"=>10, "load"=>30, "rest"=>30}]}]}
