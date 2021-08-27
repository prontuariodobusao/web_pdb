const today = new Date()

export const dateCurrent = `Data: ${today.getDate()}/${
  today.getMonth() + 1
}/${today.getFullYear()}`

export const dateFormatStr = (date: Date): string =>
  `${date.getDate()}/${date.getMonth() + 1}/${date.getFullYear()}`
