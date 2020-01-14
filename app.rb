class App
  
  def self.main
    list = YAML.load_file('./kunden.yml')
    kx = []
    #monatsabrechnungen = ["\"MONAT\", \"NAME\", \"ANZAHL\", \"LEISTUNG\", \"LEISTUNGSID\", \"GESAMTPUNKTZAHL\", \"BETRAG\", \"UMLAGE\", \"SUMME\"\n"]
    salden = ["\"MONAT\", \"ANZAHL KUNDEN\", \"BETRAG\", \"UMLAGE\", \"SUMME\"\n"]
    list.each do |k|
      id = k[0]
      von, bis = k[1]["zeitraum"].split("-")
      kx << ::Kunde.new(id, k[1]["name"], k[1]["profil"], DateTime.parse(von), DateTime.parse(bis))
    end
    
    monate = (0..35)
    monate.each do |m|
      monatsabrechnung = ["\"MONAT\", \"NAME\", \"ANZAHL\", \"LEISTUNG\", \"LEISTUNGSID\", \"GESAMTPUNKTZAHL\", \"BETRAG\", \"UMLAGE\", \"SUMME\"\n"]
      rechnungen = {}
      #puts "############################################################"
      monatsdatum = (DateTime.parse("1.8.2020") >> m)
      datum = monatsdatum.strftime("%d.%m.%Y")
      kundenanzahl = 0
      kx.each do |k|
        if k.aktiv?(datum)
          kundenanzahl += 1
          rechnungen.merge!({k.name => k.monatsrechnung(datum)})
        end
      end
      rechnungen.each do |k,v|
        #puts ""
        v.each do |posten|
          #puts posten
          monatsabrechnung << posten.to_csv
        end
      end
      File.write("./export/monatsabrechnungen/#{monatsdatum.strftime("%Y-%m")}.csv", monatsabrechnung.join(""))
      #puts "====="
      gesamt = ::Rechnung.monatsabrechnung(rechnungen.values.flatten) 
      #puts "Posten #{gesamt.betrag.round(2)} + Pauschale #{gesamt.pauschale.round(2).co} = Summe #{gesamt.summe.round(2)}"
      salden << "\"#{datum[3..-1]}\",\"#{kundenanzahl}\", \"#{gesamt.betrag.round(2).co} €\", \"#{gesamt.pauschale.round(2).co} €\",\"#{gesamt.summe.round(2).co} €\"\n"
    end
    #File.write('./export/monatsabrechnungen.csv', monatsabrechnungen.join(""))
    File.write('./export/salden.csv', salden.join(""))
    ::Leistung.Preisliste
  end

  def self.xls
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet2 = book.create_worksheet :name => 'My Second Worksheet'
    sheet1.name = 'My First Worksheet'
    sheet1.row(0).concat %w{Name Country Acknowlegement}
    sheet1[1,0] = 'Japan'
    row = sheet1.row(1)
    row.push 'Creator of Ruby'
    row.unshift 'Yukihiro Matsumoto'
    sheet1.row(2).replace [ 'Daniel J. Berger', 'U.S.A.',
                            'Author of original code for Spreadsheet::Excel' ]
    sheet1.row(3).push 'Charles Lowe', 'Author of the ruby-ole Library'
    sheet1.row(3).insert 1, 'Unknown'
    sheet1.update_row 4, 'Hannes Wyss', 'Switzerland', 'Author'
    sheet1.row(0).height = 18

    format = Spreadsheet::Format.new :color => :blue,
                                       :weight => :bold,
                                                                        :size => 18
    sheet1.row(0).default_format = format

    bold = Spreadsheet::Format.new :weight => :bold
    4.times do |x| sheet1.row(x + 1).set_format(0, bold) end
    book.write './export/finance.xls'

  end

end
