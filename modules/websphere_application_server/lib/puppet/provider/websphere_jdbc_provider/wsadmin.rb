require_relative '../websphere_helper'

Puppet::Type.type(:websphere_jdbc_provider).provide(:wsadmin, parent: Puppet::Provider::Websphere_Helper) do
  def scope(what)
    case resource[:scope]
    when 'cell'
      mod_path = "Cell=#{resource[:cell]}"
      get      = "Cell:#{resource[:cell]}"
      path     = "cells/#{resource[:cell]}"
    when 'server'
      mod_path = "Cell=#{resource[:cell]},Server=#{resource[:server]}"
      get      = "Cell:#{resource[:cell]}/Node:#{resource[:node_name]}/Server:#{resource[:server]}"
      path     = "cells/#{resource[:cell]}/nodes/#{resource[:node_name]}/servers/#{resource[:server]}"
    when 'cluster'
      mod_path = "Cluster=#{resource[:cluster]}"
      get      = "Cell:#{resource[:cell]}/ServerCluster:#{resource[:cluster]}"
      path     = "cells/#{resource[:cell]}/clusters/#{resource[:cluster]}"
    when 'node'
      mod_path = "Node=#{resource[:node_name]}"
      get      = "Cell:#{resource[:cell]}/Node:#{resource[:node_name]}"
      path     = "cells/#{resource[:cell]}/nodes/#{resource[:node_name]}"
    end

    case what
    when 'mod'
      return mod_path
    when 'get'
      return get
    when 'path'
      return path
    end
  end

  def params_string
    params_list =  "-name \"#{resource[:name]}\" "
    params_list << "-scope #{scope('mod')} "
    params_list << "-databaseType \"#{resource[:dbtype]}\" "
    params_list << "-providerType \"#{resource[:providertype]}\" "
    params_list << "-implementationType \"#{resource[:implementation]}\" "
    params_list << "-description \"#{resource[:description]}\" " if resource[:description]
    params_list << "-classpath [ #{resource[:classpath]} ] " if resource[:classpath]
    params_list << "-nativePath \"#{resource[:native_path]}\" " if resource[:nativepath]

    params_list
  end

  def create
    cmd = "AdminTask.createJDBCProvider('[#{params_string}]'); AdminConfig.save()"

    debug "Creating JDBC Provider with #{cmd}"
    result = wsadmin(file: cmd, user: resource[:user])
    debug "Result: #{result}"
  end

  def exists?
    cmd = "\"print AdminConfig.list('JDBCProvider', AdminConfig.getid( '/"
    cmd << "#{scope('get')}/'))\""

    debug "Querying JDBC Provider with #{cmd}"
    result = wsadmin(command: cmd, user: resource[:user])
    debug "Result: #{result}"

    if result =~ %r{^"?#{resource[:name]}\(#{scope('path')}\|}
      debug "Found match for #{resource[:name]}"
      return true
    end

    debug "#{resource[:name]} doesn't seem to exist."
    false
  end

  def destroy
    # AdminTask.deleteJDBCProvider('(cells/CELL_01|resources.xml#JDBCProvider_1422560538842)')
    Puppet.warning('Removal of JDBC Providers is not yet implemented')
  end

  def flush
    case resource[:scope]
    when %r{(server|node)}
      sync_node
    end
  end
end
