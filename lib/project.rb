class Project
  attr_reader :title, :id
  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id) || nil
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(other_project)
    @title == other_project.title
  end

  def self.all
    projects_out = DB.exec("SELECT * FROM projects;")
    projects_out.map do |project|
      Project.new({
        title: project['title'],
        id: project['id'].to_i,
        })
    end
  end

  def self.find(id_find)
    Project.all.each do |project|
      if project.id == id_find
        return project
      end
    end
  end

  def volunteers
    volunteers_list = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id} ORDER BY name;")
    volunteers_list.map do |result|
      Volunteer.new({
        id: result["id"].to_i,
        name: result["name"],
        project_id: result["project_id"].to_i
      })
    end
  end

  def update(attributes)
    @title = attributes[:title]
    @id = self.id
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = '#{@id}';")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id};")
  end
end
