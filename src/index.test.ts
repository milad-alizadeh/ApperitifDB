import { sayHello } from './'

test('should log "Hello, world!" when called with "world"', () => {
  const consoleSpy = jest.spyOn(console, 'log')
  sayHello('world')
  expect(consoleSpy).toHaveBeenCalledWith('Hello, world!')
  consoleSpy.mockRestore()
})
