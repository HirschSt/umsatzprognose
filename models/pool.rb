class Pool
  def self.profile
    res = []
    res.fill(1, res.size, 5)
    res.fill(2, res.size, 4)
    res.fill(3, res.size, 3)
    res.fill(4, res.size, 2)
    res.fill(5, res.size, 1)
    return res
  end

  def self.name
    return "#{Pflegedienst::NAMEN['first_name'].sample} #{Pflegedienst::NAMEN['last_name'].sample}"
  end
  
  def self.create
    kurve = Verlauf.new.kurve
    res = []
    kurve.each do |e|
      von = DateTime.parse(e["DATUM"])
      bis = DateTime.parse("1.8.2023")
      anzahl = e["ANZAHL"].to_i - res.size
      (1..anzahl).each do |id|
        res << Kunde.new(id, self.name, self.profile.sample, von, bis)
      end
      next
    end
    return res
 
  end
end
