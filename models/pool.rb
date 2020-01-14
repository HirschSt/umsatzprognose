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
    res.fill("1.8.2020-30.9.2020", res.size, 4)
    res.fill("1.9.2020-31.10.2020", res.size, 4)
    res.fill("1.10.2020-30.11.2020", res.size, 4)
    res.fill("1.11.2020-31.12.2020", res.size, 4)
    res.fill("1.12.2020-31.1.2021", res.size, 4)
    res.fill("1.1.2021-28.2.2021", res.size, 4)
    res.fill("1.2.2021-31.3.2021", res.size, 4)
    res.fill("1.3.2021-30.4.2021", res.size, 4)
    res.fill("1.4.2021-31.5.2021", res.size, 4)
    res.fill("1.5.2021-30.6.2021", res.size, 5)
    res.fill("1.6.2021-31.7.2021", res.size, 5)
    res.fill("1.7.2021-31.8.2021", res.size, 5)
    res.fill("1.8.2021-30.9.2021", res.size, 5)
    res.fill("1.9.2021-31.10.2021", res.size, 5)
    res.fill("1.10.2021-30.11.2021", res.size, 5)
    res.fill("1.11.2021-31.12.2021", res.size, 5)
    res.fill("1.12.2021-31.1.2022", res.size, 5)
    res.fill("1.1.2022-28.2.2022", res.size, 5)
    res.fill("1.2.2022-31.3.2022", res.size, 5)
    res.fill("1.3.2022-30.4.2022", res.size, 5)
    res.fill("1.4.2022-31.5.2022", res.size, 5)
    res.fill("1.5.2022-30.6.2022", res.size, 6)
    res.fill("1.6.2022-31.7.2022", res.size, 6)
    res.fill("1.7.2022-31.8.2022", res.size, 6)
    res.fill("1.8.2022-30.9.2022", res.size, 6)
    res.fill("1.9.2022-31.10.2022", res.size, 6)
    res.fill("1.10.2022-30.11.2022", res.size, 6)
    res.fill("1.11.2022-31.12.2022", res.size, 6)
    res.fill("1.12.2022-31.1.2023", res.size, 6)
    res.fill("1.1.2023-28.2.2023", res.size, 6)
    res.fill("1.2.2023-31.3.2023", res.size, 6)
    res.fill("1.3.2023-30.4.2023", res.size, 7)
    res.fill("1.4.2023-31.5.2023", res.size, 7)
    res.fill("1.5.2023-30.6.2023", res.size, 7)
    res.fill("1.6.2023-31.7.2023", res.size, 7)
    res.fill("1.7.2023-31.7.2023", res.size, 7)
    return res
  end

  def self.create
    res = []
    (1..750).each do |id|
      von, bis = self.zeitraum.sample.split("-")
      res << Kunde.new(id, self.name, self.profile.sample, DateTime.parse(von), DateTime.parse(bis))
    end
    return res
  end
end
