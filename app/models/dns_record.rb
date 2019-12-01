class DnsRecord < ApplicationRecord
  belongs_to :zone, touch: true

  enum record_type: [ :A, :AAAA, :CNAME, :NS, :PTR, :TXT ]
  validates :record_type, inclusion: { in: record_types.keys }

  def dump
    records = {
      "A" => DNS::Zone::RR::A.new,
      "AAAA" => DNS::Zone::RR::AAAA.new,
      "CNAME" => DNS::Zone::RR::CNAME.new,
      "NS" => DNS::Zone::RR::NS.new,
      "PTR" => DNS::Zone::RR::PTR.new,
      "TXT" => DNS::Zone::RR::TXT.new,
    }
    rec = records[record_type]
    rec.ttl = ttl
    rec.label = name
    rec.address = value
    rec
  end
end
