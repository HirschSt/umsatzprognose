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

  def self.zeitraum
    res = []
    (0..35).each do |dat|
      if dat < 2
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 40)
      elsif dat < 5
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 32 )
      elsif dat < 10
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 16 )
      elsif dat < 15
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 8 )
      elsif dat < 20
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 6)
      elsif dat < 25
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 6)
      elsif dat < 30
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 5)
      else
        res.fill("#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}-31.7.2023", res.size, 5)
      end
    end
    #Volatilität
    (0..17).each do |dat|
      a = "#{(Pflegedienst::STARTDATUM >> dat).strftime("%d.%m.%Y")}"
      o = "#{(Pflegedienst::STARTDATUM >> 35 << dat).strftime("%d.%m.%Y")}"
      if dat < 5
        res.fill("#{a}-#{o}", res.size, 4)
      else
        res.fill("#{a}-#{o}", res.size, 2)
      end
    end
    return res
  end

  def self.create
    zr =self.zeitraum
    res = []
    (1..Pflegedienst::ZIELGROESSE + 10).each do |id|
      von, bis = zr.sample.split("-")
      res << Kunde.new(id, self.name, self.profile.sample, DateTime.parse(von), DateTime.parse(bis))
    end
    return res
  end
end
