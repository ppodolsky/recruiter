class ResetRolesExperimentsCategoriesSessions < ActiveRecord::Migration
  def change
    revert CreateExperiments
    revert CreateSessions
    revert CreateExperimentsExperimentersJoinTable
    revert CreateCategories
    revert CreateCategoriesExperimentsJoinTable
    revert RolifyCreateExperimenters
    revert RolifyCreateSubjects
    revert RolifyCreateAdmins
    revert CreateSessionsSubjectsJoinTable
  end
end
