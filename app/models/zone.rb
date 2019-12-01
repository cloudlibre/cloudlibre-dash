class Zone < ApplicationRecord
  belongs_to :user
  has_many :dns_records, dependent: :destroy

  def dump
    zone = DNS::Zone.new
    zone.soa.serial = updated_at.strftime("%Y%m%d01")
    zone.origin = "#{self.name}."
    zone.ttl = '1d'

    # quick access to SOA RR
    zone.soa.nameserver = 'ns0.cloudlibre.example.com.'
    zone.soa.email = 'hostmaster.cloudlibre.example.com.'

    # add an A RR
    self.dns_records.each do |rec|
      zone.records << rec.dump unless rec.record_type.nil?
    end
    # output using dns zone file format
    zone.dump
  end

  def to_param
    name
  end
end
