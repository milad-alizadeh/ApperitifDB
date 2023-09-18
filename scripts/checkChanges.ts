import { execSync } from 'child_process'
import { readFileSync, writeFileSync, existsSync } from 'fs' // <-- Added existsSync
import { join, basename, extname } from 'path'

const getChangedFiles = (): string[] => {
  const gitDiffOutput = execSync('git diff --cached --name-only', {
    encoding: 'utf8',
  })
  const allChangedFiles = gitDiffOutput.trim().split('\n')
  const sqlChangedFiles = allChangedFiles.filter(
    (file) => file.startsWith('supabase/postgres/') && file.endsWith('.sql'),
  )

  return sqlChangedFiles
}

const getBaseFileName = (filePath: string): string => {
  const extension = extname(filePath)
  return basename(filePath, extension)
}

const generateMigrationName = (baseName: string): string => {
  const now = new Date()
  const year = now.getFullYear()
  const month = (now.getMonth() + 1).toString().padStart(2, '0') // Months are 0 indexed
  const date = now.getDate().toString().padStart(2, '0')
  const hour = now.getHours().toString().padStart(2, '0')
  const minute = now.getMinutes().toString().padStart(2, '0')
  const second = now.getSeconds().toString().padStart(2, '0')

  return `${year}${month}${date}${hour}${minute}${second}_${baseName}.sql`
}

const copyChangedContent = (filePath: string, migrationPath: string): void => {
  const content = readFileSync(filePath, 'utf8')
  writeFileSync(migrationPath, content)
}

const main = (): void => {
  const changedSqlFiles = getChangedFiles()

  changedSqlFiles.forEach((filePath) => {
    if (!existsSync(filePath)) {
      // <-- Check if the file exists
      console.log(`File ${filePath} does not exist. Skipping...`)
      return // Skip the current iteration if the file doesn't exist
    }

    const baseName = getBaseFileName(filePath)
    const migrationName = generateMigrationName(baseName)
    const migrationPath = join('supabase', 'migrations', migrationName)

    copyChangedContent(filePath, migrationPath)
  })
}

main()
