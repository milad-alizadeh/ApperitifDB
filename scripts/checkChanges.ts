import { execSync } from 'child_process'
import { readFileSync } from 'fs'
import { join } from 'path'

const getChangedFiles = (): string[] => {
  const result: string = execSync('git diff --cached --name-only', {
    encoding: 'utf8',
  })
  return result.trim().split('\n')
}

const copyChangedContent = (filePath: string, migrationPath: string): void => {
  const content = readFileSync(filePath, 'utf8')
  execSync(`echo "${content}" >> ${migrationPath}`)
}

const changedFiles = getChangedFiles()

const relevantFolders = ['functions', 'settings', 'types']

const changedSqlFiles = changedFiles.filter(
  (file) =>
    relevantFolders.some((folder) =>
      file.startsWith(join('supabase', 'postgress', folder)),
    ) && file.endsWith('.sql'),
)

if (changedSqlFiles.length) {
  const migrationName = `migration_${new Date().toISOString()}.sql` // This creates a migration name based on the current date and time. Adjust as needed.
  const migrationPath = join(
    'supabase',
    'postgress',
    'migrations',
    migrationName,
  )
  execSync(`touch ${migrationPath}`) // Creates an empty migration file

  changedSqlFiles.forEach((file) => {
    copyChangedContent(file, migrationPath)
  })
}
