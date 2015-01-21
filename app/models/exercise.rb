class Exercise
  PROPERTIES = [:id, :name, :sets, :reps, :load, :rest,
    :status, :current_set, :routine, :pos]
  PROPERTIES.each { |p| attr_accessor p }

  def initialize(hash = {})
    hash.each do |k, v|
      if PROPERTIES.member?(k.to_sym)
        self.send("#{k.to_s}=", v)
      end
    end
    reset
  end

  def reset
    @status = 'not_started'
    @current_set = 0
  end

  def start
    next_set
    @status = 'started'
  end

  def rest
    raise 'Not started' unless started?
    @status = 'resting'
  end

  def started?
    @status == 'started'
  end

  def next_set
    # if @current_set < @reps
    @current_set += 1
  end

  def to_s
    self.name
  end

  # def start
  #   puts "[Exercise] start (#{self.status})"
  #   self.status = "started"
  #   self.current_set ||= 0
  #   self.current_set += 1

  #   if self.current_set > self.sets
  #     self.next
  #   else
  #     self
  #   end
  # end

  def finish
    self.status = "finished"
  end

  def reps_label
    label = "#{sets}x"

    if reps.is_a?(Array)
      label = "#{label}..."
    else
      label = "#{label}#{reps}"
    end

    label = "#{label} #{rest}\""
  end

  def label
    "#{name} (#{reps_label})"
  end
end
