# Drop all the old Rels

Rel.all.each{|r| r.destroy}

#Make our standard ones
Rel.create :slug        => "current-application-version",
           :description => "The linked resource describes the most recently released version of the desktop application."
Rel.create :slug        => "rel-index",
           :description => "This relation is the root resource for rels. It contains the list of all rels we've defined."
Rel.create :slug        => "rel",
           :description => "This relation is a link to a rel resource."
Rel.create :slug        => "program-index",
           :description => "This relation is the root resource for programs. It contains the list of all programs."
Rel.create :slug        => "program",
           :description => "This relation is a link to a program resource."
Rel.create :slug        => "program-new",
           :description => "This relation is a link to a form that will allow you to make a program resource."
