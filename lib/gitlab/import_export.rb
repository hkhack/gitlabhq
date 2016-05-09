module Gitlab
  module ImportExport
    extend self

    def export_path(relative_path:)
      File.join(storage_path, relative_path)
    end

    def project_attributes
      %i(name path description issues_enabled wall_enabled merge_requests_enabled wiki_enabled snippets_enabled visibility_level archived)
    end

    def project_tree_list
      project_tree.map {|r| r.is_a?(Hash) ? r.keys.first : r }
    end

    def project_tree
      Gitlab::ImportExport::ImportExportReader.new.project_tree
    end

    def storage_path
      File.join(Settings.shared['path'], 'tmp/project_exports')
    end
  end
end
