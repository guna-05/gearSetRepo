const labels = () => [
    'Biology', 
    'Chemistry', 
    'Civics', 
    'Economics', 
    'History', 
    'Maths', 
    'Physics'
]

const backgroundColor = () => [
    'rgba(255, 99, 132, 0.2)',
    'rgba(255, 159, 64, 0.2)',
    'rgba(255, 205, 86, 0.2)',
    'rgba(75, 192, 192, 0.2)',
    'rgba(54, 162, 235, 0.2)',
    'rgba(153, 102, 255, 0.2)',
    'rgba(201, 203, 207, 0.2)'
  ]
const borderColor = () => [
    'rgb(255, 99, 132)',
    'rgb(255, 159, 64)',
    'rgb(255, 205, 86)',
    'rgb(75, 192, 192)',
    'rgb(54, 162, 235)',
    'rgb(153, 102, 255)',
    'rgb(201, 203, 207)'
  ]

  const columns = () => [{label: 'Biology', fieldName: 'Biology', type: 'number'},
    {label: 'Chemistry', fieldName: 'Chemistry', type: 'number'},
    {label: 'Civics', fieldName: 'Civics', type: 'number'},
    {label: 'Economics', fieldName: 'Economics', type: 'number'},
    {label: 'History', fieldName: 'History', type: 'number'},
    {label: 'Maths', fieldName: 'Maths', type: 'number'},
    {label: 'Physics', fieldName: 'Physics', type: 'number'},
    {label: 'Total', fieldName: 'Total', type: 'number'}
]

export {backgroundColor, borderColor, columns, labels}