var FeatureTable = React.createClass({
    getInitialState: function(){
        return { features: [
            {
                name: 'Test',
                id: 999,
                status: 'failed'
            },
            {
                name: 'Test2',
                id: 998,
                status: 'passed'
            } ] }
    },
    getFeatureRows: function() {
      return this.state.features.map(function(object, i){
          return <FeatureRow id={object.id} name={object.name} status={object.status} key={object.id} />
      });
    },
    render: function() {
        return (
            <div id="features-wrapper">
                <div id="features-title">
                    Features
                </div>
                <div className="list-group">
                    { this.getFeatureRows() }
                </div>
            </div>
        )
    }
});

var FeatureRow = React.createClass({
    getStatusIcon: function(){
        var statusIcon = null;

        if(this.props.status.toLowerCase() == 'passed') {
            statusIcon = 'thumbs-up'
        } else {
            statusIcon = 'thumbs-down'
        }

        return statusIcon;
    },
    render: function() {
        return (
            <div data-feature-id={this.props.id} className="list-group-item">
                <div className="feature-name">{this.props.name}</div>
                <div className="feature-status">{this.props.status}</div>
                <div className="feature-icon">
                    <i className={ 'fa fa-' + this.getStatusIcon() } />
                </div>
            </div>
        )
    }
});

ReactDOM.render(<FeatureTable />, document.getElementById('features-content'));