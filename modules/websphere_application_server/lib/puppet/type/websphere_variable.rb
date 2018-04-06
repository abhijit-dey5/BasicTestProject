require 'pathname'

Puppet::Type.newtype(:websphere_variable) do
  @doc = 'This manages a WebSphere environment variable'

  ensurable

  def self.title_patterns
    identity = ->(x) { x }
    [
      [
        %r{^(.*):(.*):(.*):(.*)$},
        [
          [:cell, identity],
          [:scope, identity],
          [:node_name, identity],
          [:server, identity],
        ],
      ],
      [
        %r{^(.*):(.*):(.*)$},
        [
          [:cell, identity],
          [:scope, identity],
          [:node_name, identity],
        ],
      ],
      [
        %r{^(.*):(.*)$},
        [
          [:cell, identity],
          [:scope, identity],
        ],
      ],
      [
        %r{^(.*)$},
        [
          [:cell, identity],
        ],
      ],
    ]
  end

  validate do
    raise ArgumentError, "Invalid scope #{self[:scope]}: Must be cell, cluster, node, or server" unless self[:scope] =~ %r{^(cell|cluster|node|server)$}
    raise ArgumentError, 'server is required when scope is server' if self[:server].nil? && self[:scope] == 'server'
    raise ArgumentError, 'cell is required' if self[:cell].nil?
    raise ArgumentError, 'node_name is required when scope is server, cell, or node' if self[:node_name].nil? && self[:scope] =~ %r{(server|cell|node)}
    raise ArgumentError, 'cluster is required when scope is cluster' if self[:cluster].nil? && self[:scope] =~ %r{^cluster$}
    raise ArgumentError, "Invalid profile_base #{self[:profile_base]}" unless Pathname.new(self[:profile_base]).absolute?

    if self[:profile].nil?
      raise ArgumentError, 'profile is required' unless self[:dmgr_profile]
      self[:profile] = self[:dmgr_profile]
    end

    [:variable, :server, :cell, :node_name, :cluster, :profile, :user].each do |value|
      raise ArgumentError, "Invalid #{value} #{self[:value]}" unless value =~ %r{^[-0-9A-Za-z._]+$}
    end
  end

  newparam(:variable) do
    desc <<-EOT
    Required. The name of the variable to create/modify/remove.  For example,
    `LOG_ROOT`
    EOT
  end

  newparam(:scope) do
    desc <<-EOT
    The scope for the variable.
    Valid values: cell, cluster, node, or server
    EOT
  end

  newproperty(:value) do
    desc 'The value the variable should be set to.'
  end

  newproperty(:description) do
    desc 'A description for the variable'
    defaultto 'Managed by Puppet'
  end

  newparam(:server) do
    desc 'The server in the scope for this variable'
  end

  newparam(:cell) do
    desc 'The cell that this variable should be set in'
  end

  newparam(:node_name) do
    desc 'The node that this variable should be set under'
  end

  newparam(:cluster) do
    desc 'The cluster that a variable should be set in'
  end

  newparam(:profile) do
    desc "The profile to run 'wsadmin' under"
  end

  newparam(:dmgr_profile) do
    defaultto { @resource[:profile] }
    desc <<-EOT
    The dmgr profile that this variable should be set under.  Basically, where
    are we finding `wsadmin`

    This is synonomous with the 'profile' parameter.

    Example: dmgrProfile01"
    EOT
  end

  newparam(:profile_base) do
    desc "The base directory that profiles are stored.
      Example: /opt/IBM/WebSphere/AppServer/profiles"
  end

  newparam(:user) do
    defaultto 'root'
    desc "The user to run 'wsadmin' with"
  end

  newparam(:wsadmin_user) do
    desc 'The username for wsadmin authentication'
  end

  newparam(:wsadmin_pass) do
    desc 'The password for wsadmin authentication'
  end
end
