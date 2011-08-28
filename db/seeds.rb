# Drop all the old Rels

Rel.all.each{|r| r.destroy}

#Make our standard ones
Rel.create :slug        => "current-application-version",
           :description => "The linked resource describes the most recently released version of the desktop application."
Rel.create :slug        => "rel-index",
           :description => "This relation is the root resource for rels. It contains the list of all rels we've defined."
Rel.create :slug        => "rel",
           :description => "This relation is a link to a rel resource."
