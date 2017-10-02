class Volunteer
  attr_reader :name, :project_id, :id
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id} ) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def ==(other_volunteer)
    @name == other_volunteer.name
  end

  def self.all
    volunteers_out = DB.exec("SELECT * FROM volunteers;")
    volunteers_out.map do |volunteer|
      Volunteer.new({
        name: volunteer['name'],
        id: volunteer['id'].to_i,
        project_id: volunteer['project_id']
        })
    end
  end

  def self.find(id_find)
    Volunteer.all.each do |volunteer|
      if volunteer.id == id_find
        return volunteer
      end
    end
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{self.id};")
  end
end
