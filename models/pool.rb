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
    return "#{Pflegedienst::VORNAMEN.sample} #{Pflegedienst::NACHNAMEN.sample}"
  end
  
  def self.create
    kurve = Verlauf.new.kurve
    res = []
    c = 0
    kurve.each do |e|
      von = DateTime.parse(e["DATUM"])
      bis = DateTime.parse("1.8.2023")
      aktive = Kunde.aktive(e["DATUM"], res)
      anzahl = e["ANZAHL"].to_i - aktive
      (1..anzahl).each do |id|
        if c % Kunde.VOLATIL == 0
          bis2 = von >> (1..12).to_a.sample
          res << Kunde.new(c+=1, self.name, self.profile.sample, von, bis2)

        else
          res << Kunde.new(c+=1, self.name, self.profile.sample, von, bis)

        end
      end
      next
    end
    return res
 
  end
end
