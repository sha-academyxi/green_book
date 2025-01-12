import React from 'react'
import { Link } from 'react-router-dom'
import axios from 'axios'
import Child from './Child'
import '../../style/children.css'


class Children extends React.Component {
    constructor(props){
        super(props)
        this.state={
            children: []
        }
    }

    componentDidMount(){
        this.getChildren()
    }

    getChildren = () => {
        axios.get('http://localhost:3001/api/v1/children', {
          withCredentials: true,
      })
        .then(response => {
          this.handleChildren(response.data)
        })
    }

    handleChildren = (data) => {
        this.setState({
          children: data
        })
    }

    render(){
        return(
            <div>
                <div>
                    <h1>Children</h1>
                    <Link to="/">Home</Link> <Link to='/add_a_child'>Add a new child</Link>
                    {this.state.children.map(child => {
                        return (<Child key={child.id} child={child}/>)
                    })}
                </div>

            </div>
        )
    }
}

export default Children