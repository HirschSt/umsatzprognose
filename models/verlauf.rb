class Verlauf

  attr_accessor :kurve
  def initialize(verlauf="./kunden/verlauf.csv")
    @kurve = CSV.parse(File.read(verlauf), headers: true).each
  end

  def suche(datum)
    @kurve.each do |row|
      return row if row["DATUM"] == datum
    end
    return nil
  end

  
end
