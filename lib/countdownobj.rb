# CountDownObj - Count Down Object
# by Daniel P. Clark
# The MIT License

class CountDownObj
  attr_reader :second, :minute, :hour, :day, :week
  @@second = 1
  @@minute = @@second * 60
  @@hour   = @@minute * 60
  @@day    = @@hour   * 24
  @@week   = @@day    * 7
  
  def second()  @@second;  end
  def minute()  @@minute;  end
  def hour()    @@hour;    end
  def day()     @@day;     end
  def week()    @@week;    end
  
  attr_accessor :countdownto
  
  def initialize(countdownto = (Time.now + @@day))
    self.countdownto = countdownto    
  end
  
  def deadline
    self.countdownto - Time.at(Time.now.to_f)
  end
  
  def to_s
    out = ""
    val = []
    [[@@week, "week"], [@@day, "day"], [@@hour, "hour"], [@@minute, "minute"], [@@second, "second"]].each do |tm|
      if val.empty?
        val = deadline.divmod(tm[0])
      else
        val = val[1].divmod(tm[0])
      end
      if val[0] > 0
        out << "#{val[0]} "
        if val[0] > 1
          out << "#{tm[1]}s"
        else
          out << "#{tm[1]}"
        end
        if not tm[1] == "second"
          out << ", "
        end
      end
    end
    if deadline.to_i <= 0
      out = 'deadline'
    else
      out.chomp(", ")
    end
  end
  
  def deadline=(timeObject)
    self.countdownto = Time.at(timeObject)
  end
end
