export default [
  {
    name: 'ounce',
    isConvertable: true,
    plural: 'ounces',
    abbreviation: 'oz',
  },

  {
    name: 'ml',
    isConvertable: true,
    plural: 'ml',
    abbreviation: 'ml',
  },
  {
    name: 'dash',
    isConvertable: false,
    plural: 'dashes',
    abbreviation: 'dash',
  },
  { name: 'drop', isConvertable: false, plural: 'drops', abbreviation: 'drop' },
  { name: 'tsp', isConvertable: false, plural: 'tsp', abbreviation: 'tsp' },
  { name: 'tbsp', isConvertable: false, plural: 'tbsps', abbreviation: 'tsp' },
  { name: 'cup', isConvertable: true, plural: 'cups', abbreviation: 'cup' },
] as any
