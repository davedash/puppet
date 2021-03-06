require 'puppet/provider/cisco'

Puppet::Type.type(:vlan).provide :cisco, :parent => Puppet::Provider::Cisco do

  desc "Cisco switch/router provider for vlans."

  mk_resource_methods

  def self.lookup(device, id)
    vlans = {}
    device.command do |d|
      vlans = d.parse_vlans || {}
    end
    vlans[id]
  end

  def initialize(device, *args)
    super
  end

  # Clear out the cached values.
  def flush
    device.command do |device|
      device.update_vlan(resource[:name], former_properties, properties)
    end
    super
  end
end
