import React, { Component } from 'react'
import Header from './components/Header'

class App extends Component {
  render() {
    const {
      logged_in,
      current_user,
      new_user_route,
      sign_in_route,
      sign_out_route
    } = this.props
    console.log("logged_in:", logged_in)
    console.log("current_user:", current_user)
    console.log("new_user_route:", new_user_route)
    console.log("sign_in_route:", sign_in_route)
    console.log("sign_out_route:", sign_out_route)
    return (
      <>
        <Header {...this.props} />

        <h1>React in Rails with Devise</h1>
        
      </>
    )
  }
}

export default App